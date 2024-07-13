import { defineStore } from 'pinia'

export const useWorkspacesStore = defineStore('workspaces', {
  state: () => ({
    workspaces: [],
  }),
  actions: {
    getById(id) {
      this.find(element => element.id === id)
    }
  }
})