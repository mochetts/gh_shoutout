import axios from 'axios'

export default {
  index(params) {
    return axios.get('/users', { params })
  }
}