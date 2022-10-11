<template>
  <div class="py-11 px-5 user-serch-backgound">
    <CardWithHeader headerText="フレンド検索" class="mb-11">
      <div class="d-flex justify-center flex-column py-7 px-11">
        <div v-if="error !== ''">
          <p class="red--text mt-5 text-h6">ユーザーが見つかりません</p>
        </div>
        <div>
          <v-text-field
            v-model="inputUserName.userName"
            label="ID"
            required
            class="mb-2"
          ></v-text-field>
        </div>
        <div class="d-flex justify-center">
          <ButtonBase color="#949494" @click.native="cancel" class="mr-7" >キャンセル</ButtonBase>
          <ButtonBase color="#E8730E" @click.native="submitData">検索</ButtonBase>
        </div>
      </div>
    </CardWithHeader>
    <CardWithHeader :headerText="friendIndexCardText">
      <div class="d-flex justify-center flex-column py-7 px-11">

      </div>
    </CardWithHeader>
  </div>
</template>

<script>
import axios from 'axios';
import CardWithHeader from './modules/CardWithHeader.vue'
import ButtonBase from './modules/ButtonBase.vue'
import moment from 'moment';

axios.interceptors.request.use((config) => {
  if(['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-Requested-With'] = 'XMLHttpReq'
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});

export default {
  components: { CardWithHeader, ButtonBase },
  data: function () {
    return {
      inputUserName: {
        userName: ''
      },
      error: ''
    }  
  },
  computed: {
    formatDate: function() {
      moment.locale("ja");
      return moment(new Date()).format("MM月DD日")
    },
    friendIndexCardText() {
      return `フレンド ${this.formatDate}の記録`
    }
  },
  methods: {
    submitData: function() {
      if( this.inputUserName === '' ) {
        this.error = 'error';
      } else {
        this.error = '';
        axios
          .post('/requests', this.inputUserName)
          .then(response => {
            let e = response;
            this.$router.push({name: 'UserDetailPage', params: { id: e.data.id } })
          })
          .catch(this.error = 'error')
      }
    },
    cancel: function() {
      this.inputUserName.userName = ''
    }
  }
}
</script>

<style scoped>
.user-serch-backgound {
  display: block;
  background-color: #F1F1F1;
}
</style>