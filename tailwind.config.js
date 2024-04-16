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
          "base-content": "#3E3E1A",
          "neutral": "#F6F6E9",
          "primary": "#BFBF65",
          "secondary": "#D3D395",
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
