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
    extend: {
      fontFamily: {
        main: ['Kiwi Maru', 'serif'],
      },
    },
  },

  daisyui: {
    themes: [
      {
        mytheme: {
          "base-content": "#592926",
          "neutral": "#e3f4fb",
          "primary": "#56BEE9", 
          "secondary": "#7bcbec",
          "accent": "#FFC42B",
          "success": "8be17f",
          "error": "#f46262",
          "warning": "#f1e747",
          "info": "#9EE1FB",
        },
      },
      "cupcake",
    ],
    darkTheme: false,
  },
}
