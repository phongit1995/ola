import { useState } from 'react'
import { Alert, App, Button, Card, Input, Space, Spin, Typography } from 'antd'
import { ExperimentOutlined, SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import {
  CONTENT_CHECK_REASON_LABEL,
  CONTENT_CHECK_TEXT_MAX,
  CONTENT_FILTER_SETTING_KEY,
  CONTENT_FILTER_WORD_LENGTH_MAX,
  CONTENT_FILTER_WORDS_MAX,
  DEFAULT_CONTENT_FILTER_SETTING,
} from './constants'
import { parseBannedWords } from './utils'
import { useCheckContent } from './useMegaphoneQueries'

function BannedWordsEditor({ initialWords }: { initialWords: string[] }) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const check = useCheckContent()
  const [text, setText] = useState(initialWords.join('\n'))
  const [sample, setSample] = useState('')
  const words = parseBannedWords(text)

  async function save() {
    const tooLong = words.find((word) => Array.from(word).length > CONTENT_FILTER_WORD_LENGTH_MAX)
    if (tooLong != null) {
      message.error(`Mỗi từ cấm tối đa ${CONTENT_FILTER_WORD_LENGTH_MAX} ký tự: ${tooLong}`)
      return
    }
    if (words.length > CONTENT_FILTER_WORDS_MAX) {
      message.error(`Tối đa ${CONTENT_FILTER_WORDS_MAX} từ cấm`)
      return
    }
    try {
      await putSetting.mutateAsync({ key: CONTENT_FILTER_SETTING_KEY, value: { bannedWords: words } })
      setText(words.join('\n'))
      message.success(`Đã lưu ${words.length} từ cấm`)
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  const result = check.data

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%', maxWidth: 680 }}>
      <Card title="Từ cấm">
        <Typography.Paragraph type="secondary">
          Mỗi dòng một từ hoặc cụm từ. Đang áp dụng cho loa: dính từ cấm thì không phát được và không bị trừ KEN.
          So khớp không phân biệt hoa thường, có dấu hay không dấu, và bắt cả kiểu viết tách “đ.ị.t”, “d i t”. Một
          từ chỉ khớp khi đứng riêng, nên “dit” không chặn nhầm “đi tắm”. Link và tên trang web luôn bị chặn sẵn.
        </Typography.Paragraph>
        <Input.TextArea
          rows={14}
          value={text}
          onChange={(event) => setText(event.target.value)}
          placeholder={'nạp ken giá rẻ\nliên hệ zalo\n…'}
        />
        <Space style={{ marginTop: 12, justifyContent: 'space-between', width: '100%' }}>
          <Typography.Text type="secondary">{words.length} từ (đã bỏ dòng trống và dòng trùng)</Typography.Text>
          <Button type="primary" icon={<SaveOutlined />} loading={putSetting.isPending} onClick={() => void save()}>
            Lưu
          </Button>
        </Space>
      </Card>

      <Card title="Thử một câu">
        <Typography.Paragraph type="secondary">
          Kiểm tra theo danh sách đã lưu trên server (lưu trước rồi mới thử nếu vừa sửa).
        </Typography.Paragraph>
        <Space.Compact style={{ width: '100%' }}>
          <Input
            value={sample}
            maxLength={CONTENT_CHECK_TEXT_MAX}
            onChange={(event) => setSample(event.target.value)}
            onPressEnter={() => sample.trim() !== '' && check.mutate(sample)}
            placeholder="Nhập câu muốn thử"
          />
          <Button
            icon={<ExperimentOutlined />}
            loading={check.isPending}
            disabled={sample.trim() === ''}
            onClick={() => check.mutate(sample)}
          >
            Thử
          </Button>
        </Space.Compact>
        {result != null && (
          <Alert
            style={{ marginTop: 12 }}
            type={result.blocked ? 'error' : 'success'}
            showIcon
            message={
              result.blocked
                ? `Bị chặn: ${result.reason != null ? CONTENT_CHECK_REASON_LABEL[result.reason] : ''}${result.word ? ` (“${result.word}”)` : ''}`
                : 'Không bị chặn'
            }
          />
        )}
        {check.isError && (
          <Alert style={{ marginTop: 12 }} type="warning" showIcon message={errorMessage(check.error, 'Thử thất bại')} />
        )}
      </Card>
    </Space>
  )
}

export function BannedWordsPage() {
  const { data: settings, isLoading, isError } = useAppSettings()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }

  if (isError) {
    return (
      <Card title="Từ cấm" style={{ maxWidth: 680 }}>
        <Typography.Text type="danger">
          Không tải được danh sách hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  const current = settingValue(settings, CONTENT_FILTER_SETTING_KEY, DEFAULT_CONTENT_FILTER_SETTING)
  return <BannedWordsEditor initialWords={current.bannedWords ?? []} />
}
