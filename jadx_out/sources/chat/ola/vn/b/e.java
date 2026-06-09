package chat.ola.vn.b;

import android.content.Context;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public abstract class e extends h {
    private View g;
    private int h;

    public e(Context context) {
        super(context);
        this.g = null;
        this.h = context.getResources().getDimensionPixelSize(R.dimen.metric_8dp);
    }

    private void a(OlaCachedImageView olaCachedImageView) {
        if (olaCachedImageView != null) {
            chat.ola.vn.c.t.a().g(chat.ola.vn.h.a(), olaCachedImageView);
        }
    }

    @Override // chat.ola.vn.b.h, chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        if (i == 0) {
            if (view == null) {
                this.g = this.a.inflate(R.layout.mall_comment_input_span, viewGroup, false);
                a((OlaCachedImageView) this.g.findViewById(R.id.imgMallItemAvatar));
                final EditText editText = (EditText) this.g.findViewById(R.id.txtMallSearchInput);
                editText.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.b.e.1
                    @Override // android.widget.TextView.OnEditorActionListener
                    public boolean onEditorAction(TextView textView, int i2, KeyEvent keyEvent) {
                        if (i2 != 4) {
                            if (keyEvent == null) {
                                return false;
                            }
                            try {
                                if (keyEvent.getKeyCode() != 66) {
                                    return false;
                                }
                            } catch (Throwable unused) {
                                return false;
                            }
                        }
                        if (editText.length() <= 0) {
                            return true;
                        }
                        e.this.a(editText.getText().toString(), editText);
                        editText.setText("");
                        return true;
                    }
                });
                return this.g;
            }
            try {
                this.g.findViewById(R.id.linearMallCommentSpan).setBackgroundResource(getCount() == 1 ? R.drawable.bg_shadow_2_edges : R.drawable.bg_me_comment_top_item);
            } catch (Throwable unused) {
            }
        }
        return super.a(i, view, viewGroup);
    }

    @Override // chat.ola.vn.b.h, android.widget.Adapter
    /* JADX INFO: renamed from: a */
    public chat.ola.vn.entry.b getItem(int i) {
        return super.getItem(Math.max(0, i - 1));
    }

    @Override // chat.ola.vn.b.h
    protected void a(int i, chat.ola.vn.entry.b.j jVar, chat.ola.vn.entry.b bVar) {
        jVar.a(i == getCount() + (-1) ? R.drawable.bg_me_comment_item_footer : R.drawable.bg_me_comment_item);
        jVar.a(this.h, 0, this.h, 0);
    }

    protected abstract void a(String str, EditText editText);

    @Override // chat.ola.vn.b.h, chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        return super.getCount() + 1;
    }

    @Override // chat.ola.vn.b.h, android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return i == 0 ? super.getViewTypeCount() : super.getItemViewType(i);
    }

    @Override // chat.ola.vn.b.h, android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return super.getViewTypeCount() + 1;
    }
}
