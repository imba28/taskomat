<template>
<div>
  <div class="title__container">
    <h1 class="login__title">Login</h1>
  </div>
  <div class="logo__container">
    <img src="../assets/tom-logo-blue.svg" alt="Unser Robomaskottchen">
  </div>
  <div class="form__container">
    <form v-on:submit.prevent="signIn">
      <div class="input__container">
        <input ref="email" id="email" class="input" type="text" placeholder="Deine Email" />
        <label class="input__label" id="email__label" for="email">
            <span class="icon-mail"></span>
          </label>
      </div>
      <div class="input__container">
        <input ref="password" id="password" class="input" type="password" placeholder="Dein Password" />
        <label class="input__label" id="password__label" for="password">
            <span class="icon-key"></span>
          </label>
      </div>
      <div class="text-center">
        <a href="#" class="link--more" id="forgot_password">Passwort vergessen?</a>
        <div>
          <button class="btn btn--default display--center display--block">Login</button>
        </div>
      </div>
    </form>
  </div>
  <div class="registertext__container text--center">
    <p>Noch kein Konto?</p>
    <a href="#/register">Registrieren</a>
  </div>
</div>
</template>

<script>
import auth from '@/auth'
import router from '@/router'

export default {
  name: 'login-page',
  data() {
    return {
      page: "Login"
    }
  },
  methods: {
    signIn() {
      const email = this.$refs['email'].value
      const password = this.$refs['password'].value

      auth.signIn(email, password)
        .then((user) => {
          router.push({
            path: '/tasks'
          })
        })
    }
  }
}
</script>

<style lang="scss">
.view {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    margin-bottom: 100px;
}

.title__container {
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    height: 3em;
    margin-top: 0.7em;
    margin-bottom: 1.8em;
}

.logo__container {
    display: flex;
    flex-direction: row;
    justify-content: center;
    height: 6em;
    margin-bottom: 1.2em;
}

.form__container form {
    flex-flow: row wrap;
    justify-content: space-around;
    display: flex;
    flex-direction: column;
    align-items: center;
    align-content: center;

    .input__container {
        display: inline-flex;

        &::after {
            display: block;
            content: "";
        }
    }
    margin-top: 1em;
}

.login__title {
    margin-left: 0.5em;
}

#email,
#email__label,
#password,
#password__label {
    height: 3em;
    border: 1.5px solid $blue;
}

#email__label,
#password__label {
    border-right: none;
}

#password__label {
    padding-left: 23px;
    padding-right: 23px;

}

#forgot_password {
    align-self: flex-start;
    margin-bottom: 2em;
}

.registertext__container {
    margin-top: 2em;

    p {
        margin: 0 0 0.2em;
    }
}

a {
    text-decoration: underline;
}

.icon-key::before,
.icon-mail::before {
    font-size: 1.2em;
}
</style>
