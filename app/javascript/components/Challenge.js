import React, { useState, useMemo, useEffect, useRef } from 'react'
import ReactTable from 'react-table'
import DatePicker from 'react-datepicker';
import { Typeahead } from 'react-typeahead'

// API Requests
import AffinitiesRequest from 'requests/AffinitiesRequest'
import UsersRequest from 'requests/UsersRequest'

import 'react-table/react-table.css'
import 'react-datepicker/dist/react-datepicker.css';
import './Challenge.scss'

function Challenge() {
  const [affinities, setAffinities] = useState([]);
  const [users, setUsers] = useState(null);
  const [user, setUser] = useState(null);
  const [startDate, setStartDate] = useState(new Date());
  const [endDate, setEndDate] = useState(new Date());
  const userPicker = useRef(null);

  // Table columns used by the `ReactTable` component.
  const columns = useMemo(
    () => [
      {
        Header: 'Username',
        accessor: 'user',
      },
      {
        Header: 'Affinity Strength',
        accessor: 'strength',
      },
      {
        Header: 'Number Of Interactions',
        accessor: 'interactions_count',
      },
    ],
    []
  )

  // Callback to retrieve affinities once the filters are all set.
  const fetchAffinities = async (filters) => {
    const affinities = await AffinitiesRequest.index(filters)
    setAffinities(affinities.data)
  }

  // Callback to retreive the available users. In a production environment, instead of loading all users,
  // we would perform the query against the server in a throttled fashion.
  const fetchUsers = async () => {
    const users = await UsersRequest.index()
    setUsers(users.data)
  }

  const filters = () => ({ user: user, from: startDate, to: endDate })

  // We're going to fetch the users only once: when the component mounts and the users aren't set yet.
  useEffect(() => {
    if (users === null) fetchUsers()
  })

  // We're going to fetch the affintiies every time the filters change.
  useEffect(() => {
    fetchAffinities(filters())
  }, [user, startDate, endDate]);


  return (
    <React.Fragment>
      <div className="filters">
        <div className="user-picker">
          <span>User:</span>
          <Typeahead
            id="users-typeahad"
            placeholder="Start typing for results..."
            options={users || []}
            ref={userPicker}
            onOptionSelected={setUser}
            onBlur={() => userPicker.current.setState({ showResults: false })}
            onFocus={() => userPicker.current.setState({ showResults: true })}
          />
        </div>
        <div className="date-range-picker">
          <span>From:</span>
          <DatePicker
            selected={startDate}
            onChange={setStartDate}
            selectsStart
            startDate={startDate}
            endDate={endDate}
          />
          <span>To:</span>
          <DatePicker
            selected={endDate}
            onChange={setEndDate}
            selectsEnd
            startDate={startDate}
            endDate={endDate}
            minDate={startDate}
          />
        </div>
      </div>
      <ReactTable
        data={affinities}
        columns={columns}
      />
    </React.Fragment>
  );
}

export default Challenge
