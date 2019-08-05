<template >

</template>

<script>
  export default {
    created() {
      delete localStorage.token
      this.$store.dispatch('logout')
      this.$router.push('/')
    }
  }
</script>
