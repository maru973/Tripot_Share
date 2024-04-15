module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui')
  ],
  theme: {
    screens: {
      'sm': '440px', //ビューでsm:クラスとすると440以上でsm:クラスを適応。元のクラスをスマホ用にしておく
      'md': '734px', //微妙な横幅のブラウザ、タブレットサイズ以上
      'lg': '1000px', //pcサイズ以上
      'xl': '1300px', //pcブラウザでも横幅が広い時
    },
    extend: {
      fontFamily: {
        main: ['Zen Maru Gothic', 'serif'],
      },
    },
  },

  daisyui: {
    themes: [
      {
        mytheme: {
          "base-content": "#043141",
          "neutral": "#F6F6E9",
          "primary": "#0CB4F4",
          "secondary": "#7ED7F9",
          "accent": "#F68712",
          "success": "8be17f",
          "error": "#f46262",
          "warning": "#f1e747",
          "info": "#9EE1FB",
        },
      },
      "cupcake",
    ],
  },
}
