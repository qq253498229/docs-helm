import Vue from "vue";
import VueRouter from "vue-router";

import readme from './docs/cn/README.html'
import install from './docs/cn/install.html'
import using_helm from './docs/cn/using_helm.html'
import quickstart from './docs/cn/quickstart.html'

Vue.use(VueRouter);

export default new VueRouter({
    mode: 'history',
    routes: [
        {path: "/", component: {template: readme}},
        {path: "/install.html", component: {template: install}},
        {path: "/using_helm.html", component: {template: using_helm}},
        {path: "/quickstart.html", component: {template: quickstart}},
    ]
});
