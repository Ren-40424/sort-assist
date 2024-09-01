import { defineStore } from 'pinia'

export const useWorkspacesStore = defineStore('workspacesStore', {
  state: () => ({
    workspaces: [],
    isLoading: false,
  }),
  getters: {
    findWorkspace: (state) => (predicate) => {
      return Object.values(state.workspaces).find(predicate)
    }
  },
  actions: {
    add(workspace) {
      this.workspaces.push(workspace)
    },

    remove(workspace) {
      const newArray = this.workspaces.filter(item => item.id !== workspace.id)
      this.workspaces = newArray
    },
  }
})