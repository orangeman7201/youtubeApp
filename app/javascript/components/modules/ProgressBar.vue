<template>
  <div class="d-flex ">
    <v-progress-linear height="15" background-color="#D9D9D9" color="#F59744" :value="linerValue" class="liner1"></v-progress-linear>
    <div class="border"></div>
    <v-progress-linear height="15" background-color="#D9D9D9" color="#EB440C" :value="overlinerValue" class="liner2"></v-progress-linear>
  </div>
</template>

<script>
export default {
  props: ['totalDuration', 'limit'],
  computed: {
    linerValue() {
      return ( this.totalDuration / this.limit ) * 100
    },
    overlinerValue() {
      if (this.totalDuration < this.limit ) {
        return 0
      }
      return (( this.totalDuration - this.limit ) / ( this.limit * 0.25)) * 100
    }
  }
}
</script>

<style scoped>
.border {
  border: 0.5px solid #1995AD;
  background-color: #1995AD;
}
.liner1 {
  flex-basis: 75%;
}
.liner2 {
  flex-basis: 25%;
}
</style>


