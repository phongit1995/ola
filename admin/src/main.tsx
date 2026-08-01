import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { RouterProvider } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { App as AntdApp, ConfigProvider } from 'antd'
import viVN from 'antd/locale/vi_VN'
import './index.css'
import { theme } from '@/theme'
import { router } from '@/routes/router'
import { setOnUnauthorized } from '@/api/http'
import { useAuthStore } from '@/store/authStore'
import { ADMIN_ACCESS_TOKEN_KEY } from '@/lib/tokenStorage'

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 1,
      refetchOnWindowFocus: false,
    },
  },
})

setOnUnauthorized(() => {
  useAuthStore.getState().clear()
  void router.navigate('/login')
})

window.addEventListener('storage', (event) => {
  if (event.key === ADMIN_ACCESS_TOKEN_KEY && event.newValue == null) {
    useAuthStore.getState().clear()
    void router.navigate('/login')
  }
})

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <ConfigProvider locale={viVN} theme={theme}>
        <AntdApp>
          <RouterProvider router={router} />
        </AntdApp>
      </ConfigProvider>
    </QueryClientProvider>
  </StrictMode>,
)
