import { useCallback, useEffect, useRef } from 'react'
import type { FormInstance } from 'antd'

type FormValues<T> = Parameters<FormInstance<T>['setFieldsValue']>[0]

export function useServerFormValues<T extends object>(form: FormInstance<T>, value: T) {
  const serialized = JSON.stringify(value)
  const syncedRef = useRef(serialized)

  useEffect(() => {
    if (serialized === syncedRef.current) return
    syncedRef.current = serialized
    if (form.isFieldsTouched()) return
    form.setFieldsValue(value as FormValues<T>)
  }, [form, serialized, value])

  return useCallback(
    (saved: T) => {
      form.resetFields()
      form.setFieldsValue(saved as FormValues<T>)
    },
    [form],
  )
}
