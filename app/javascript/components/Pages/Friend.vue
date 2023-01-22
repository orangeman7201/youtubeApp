<template>
  <div class="py-11 px-5 user-serch-backgound">
    <CardWithHeader headerText="フレンド検索" class="mb-11">
      <div class="d-flex justify-center flex-column py-7 px-11">
        <div v-if="error !== ''" class="not-found-user">
          ユーザーが見つかりません
        </div>
        <v-alert
          v-model="isSendRequestSuccess"
          close-text="Close Alert"
          dismissible
          dense
          outlined
          type="success"
          text
          transition="scale-transition"
          class="card-alert"
        >申請しました</v-alert>
        <div>
          <v-text-field
            v-model="uuid"
            label="ID"
            required
            class="mb-2"
          ></v-text-field>
        </div>
        <FriendInfoBox v-if="serchedFriend" :user="serchedFriend"/>
        <div class="d-flex justify-center">
          <ButtonBase color="#D9D9D9" @click.native="cancel" class="mr-7" >キャンセル</ButtonBase>
          <ButtonBase color="#1995AD" @click.native="sendRequest" v-if="serchedFriend">申請</ButtonBase>
          <ButtonBase color="#1995AD" @click.native="submitData" v-else>検索</ButtonBase>
        </div>
      </div>
    </CardWithHeader>
    <CardWithHeader :headerText="friendIndexCardText">
      <div class="d-flex justify-center flex-column px-5">
        <div v-for="(friend, index) in friends" :key="friend.id" class="d-flex justify-space-between py-3" :class ="{'frined-item-border': index > 0}">
          <div class="friend-info-contents">
            <img v-if="friend.image_url" :src="friend.image_url" art="" class="mr-2 friend-image" />
            <img v-else src="~user_default.svg" art="" class="mr-2 friend-image" />
            <div class="friend-name">{{ friend.name }}</div>
          </div>
          <div class="friend-movie-info-contents">
            <div class="mr-2"><span class="friend-duration-text">{{ Math.floor(friend.duration/ 60) }}</span> 分</div>
            <div class="pt-3">/ {{ friend.limit / 60 }}<span>分</span></div>
          </div>
        </div>
      </div>
    </CardWithHeader>
  </div>
</template>

<script>
import axios from 'axios';
import CardWithHeader from '../modules/CardWithHeader.vue'
import ButtonBase from '../modules/ButtonBase.vue'
import FriendInfoBox from '../modules/FriendInfoBox.vue'
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
  components: { CardWithHeader, ButtonBase, FriendInfoBox },
  data: function () {
    return {
      uuid: '',
      friends: [],
      serchedFriend: null,
      error: '',
      isSendRequestSuccess: false,
    }  
  },
  mounted () {
    this.getFriends();
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
      if (this.uuid === '') {
        this.error = 'error';
      } else {
        this.error = '';
        axios
          .post('/api/v1/requests/serch', {
            uuid: this.uuid
          })
          .then(response => {
            this.serchedFriend = response.data
          })
          .catch(error => {
            this.error = error
          })
      }
    },
    cancel: function() {
      this.uuid = ''
      this.serchedFriend = null
    },
    getFriends: function() {
      axios
        .get(`/api/v1/friends.json`)
        .then(response => {
          response.data.forEach(element => {
            this.friends.push(element)
          });
        })
    },
    sendRequest: function() {
      axios
        .post('/api/v1/requests/create', {
            uuid: this.uuid
          })
        .then(() => {
          this.isSendRequestSuccess = true
          setTimeout(() => {
            this.isSendRequestSuccess = false
            this.uuid = ""
            this.serchedFriend = null
          }, 2000)
        })
        .catch(error => {
          console.error(error);
          console.error('Rubyの方の通信エラーです');
        })
    }
  }
}
</script>

<style scoped>
.not-found-user {
  color: #E83902;
  font-size: 15px;
}
.user-serch-backgound {
  display: block;
  background-color: #F1F1F1;
  height: 100%;
}
.friend-info-contents {
  display: flex;
  align-items: center;
}
.friend-image {
  width: 30px;
  height: 30px;
  border-radius: 50%;
}
.frined-item-border {
  border-top: 1px solid #949494;
}
.friend-name {
  font-size: 15px;
}
.friend-movie-info-contents {
  display: flex;
  align-items: center;
  font-size: 15px;
}
.friend-duration-text {
  font-weight: 400;
  font-size: 30px;
}
</style>