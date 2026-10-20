import { useState } from 'react'
import { Modal } from 'antd'
import { ConversationMessages } from './ConversationMessages'
import { useConversationDetail } from './useConversationQueries'
import { userLabel } from './utils'

interface ConversationMessagesModalProps {
  conversationId: string
  around?: string
  onClose: () => void
}

export function ConversationMessagesModal({ conversationId, around, onClose }: ConversationMessagesModalProps) {
  const { data } = useConversationDetail(conversationId)
  const [focus, setFocus] = useState(around)
  const members = data?.members.map((member) => userLabel(member.user)).join(', ')
  const title = data?.name ? `Hội thoại — ${data.name}` : members ? `Hội thoại giữa ${members}` : 'Hội thoại'

  return (
    <Modal
      open
      title={title}
      onCancel={onClose}
      centered
      width={860}
      footer={null}
      styles={{ body: { height: '74vh', overflowY: 'auto', background: '#f5f7fa', padding: 16 } }}
      destroyOnHidden
    >
      <ConversationMessages
        key={focus ?? 'latest'}
        conversationId={conversationId}
        around={focus}
        onShowLatest={() => setFocus(undefined)}
      />
    </Modal>
  )
}
