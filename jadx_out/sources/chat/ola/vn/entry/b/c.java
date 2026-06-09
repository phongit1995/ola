package chat.ola.vn.entry.b;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class c {
    public static View a(LayoutInflater layoutInflater, chat.ola.vn.message.d dVar, short s) {
        View viewInflate;
        Object dVar2;
        int i = R.layout.outgoing_chat_message_layout;
        switch (s) {
            case 0:
                viewInflate = layoutInflater.inflate(R.layout.chat_status_bubble_layout, (ViewGroup) null);
                dVar2 = new d(viewInflate);
                break;
            case 1:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new f(viewInflate);
                break;
            case 2:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new ad(viewInflate, R.layout.chat_attached_media_layout);
                break;
            case 3:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new ah(viewInflate, R.layout.chat_voice_message_item);
                break;
            case 4:
                viewInflate = layoutInflater.inflate(R.layout.chat_item_time_line, (ViewGroup) null);
                dVar2 = new g(viewInflate);
                break;
            case 5:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new u(viewInflate, R.layout.chat_message_location_item);
                break;
            case 6:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new ai(viewInflate, R.layout.chat_youtube_attachment_layout);
                break;
            case 7:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new ai(viewInflate, R.layout.chat_youtube_attachment_layout);
                break;
            case 8:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new v(viewInflate, R.layout.chat_youtube_attachment_layout);
                break;
            case 9:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new e(viewInflate, R.layout.chat_snap_pic_item);
                break;
            case 10:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new r(viewInflate, R.layout.chat_rss_layout);
                break;
            case 11:
            case 12:
            case 13:
            default:
                return null;
            case 14:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new ag(viewInflate, R.layout.chat_sticker_layout);
                break;
            case 15:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new t(viewInflate, R.layout.chat_ken_transferred_layout);
                break;
            case 16:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new af(viewInflate, R.layout.chat_sent_tradding_vip_layout);
                break;
            case 17:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new ae(viewInflate, R.layout.chat_received_tradding_vip_layout);
                break;
            case 18:
                if (dVar.d() != 2) {
                    i = R.layout.incoming_chat_message_layout;
                }
                viewInflate = layoutInflater.inflate(i, (ViewGroup) null);
                dVar2 = new s(viewInflate, R.layout.chat_invitation_to_chatgroup_layout);
                break;
        }
        viewInflate.setTag(dVar2);
        return viewInflate;
    }
}
