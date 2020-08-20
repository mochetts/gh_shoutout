import axios from 'axios'

export default {
  index(params) {
    return axios.get('/affinities', { params })
  }
}