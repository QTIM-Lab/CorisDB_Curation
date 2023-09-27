// Composables
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    component: () => import('@/layouts/default/Default.vue'),
    children: [
      {
        path: '',
        name: 'Home',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "home" */ '@/views/Home.vue'),
      },
      {
        path: 'coris_db',
        name: 'coris_db',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "coris_db" */ '@/views/Coris_DB.vue'),
        children: [
          {
            path: 'amd',
            name: 'amd',
            // route level code-splitting
            // this generates a separate chunk (about.[hash].js) for this route
            // which is lazy-loaded when the route is visited.
            component: () => import(/* webpackChunkName: "amd" */ '@/views/AMD.vue'),
          },
          {
            path: 'glaucoma_click',
            name: 'glaucoma_click',
            // route level code-splitting
            // this generates a separate chunk (about.[hash].js) for this route
            // which is lazy-loaded when the route is visited.
            component: () => import(/* webpackChunkName: "glaucoma_click" */ '@/views/GlaucomaClick.vue'),
          },
          {
            path: 'glaucoma_hover',
            name: 'glaucoma_hover',
            // route level code-splitting
            // this generates a separate chunk (about.[hash].js) for this route
            // which is lazy-loaded when the route is visited.
            component: () => import(/* webpackChunkName: "glaucoma_hover" */ '@/views/GlaucomaHover.vue'),
          },
          {
            path: 'glaucoma_bb',
            name: 'glaucoma_bb',
            // route level code-splitting
            // this generates a separate chunk (about.[hash].js) for this route
            // which is lazy-loaded when the route is visited.
            component: () => import(/* webpackChunkName: "glaucoma_bb" */ '@/views/GlaucomaBB.vue'),
          },
          {
            path: 'glaucoma',
            name: 'glaucoma',
            // route level code-splitting
            // this generates a separate chunk (about.[hash].js) for this route
            // which is lazy-loaded when the route is visited.
            component: () => import(/* webpackChunkName: "glaucoma" */ '@/views/Glaucoma.vue'),
          },
          {
            path: 'glaucoma_scott',
            name: 'glaucoma_scott',
            // route level code-splitting
            // this generates a separate chunk (about.[hash].js) for this route
            // which is lazy-loaded when the route is visited.
            component: () => import(/* webpackChunkName: "glaucoma_scott" */ '@/views/GlaucomaScott.vue'),
          },
          // {
          //   path: 'amd',
          //   name: 'amd',
          //   // route level code-splitting
          //   // this generates a separate chunk (about.[hash].js) for this route
          //   // which is lazy-loaded when the route is visited.
          //   component: () => import(/* webpackChunkName: "amd" */ '@/views/AMD.vue'),
          // },  
        ]
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
