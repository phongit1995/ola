package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.TextView;
import chat.ola.vn.R;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b extends BaseExpandableListAdapter {
    private LayoutInflater a;
    private List<chat.ola.vn.entry.a.b> b;

    private class a {
        TextView a;
        TextView b;
        TextView c;

        public a(View view) {
            this.a = (TextView) view.findViewById(R.id.txtConfigTitle);
            this.b = (TextView) view.findViewById(R.id.txtConfigSubTitle);
            this.c = (TextView) view.findViewById(R.id.txtConfigAction);
            view.setTag(this);
        }

        public void a(chat.ola.vn.entry.a.c<?> cVar) {
            TextView textView;
            String strF;
            try {
                this.a.setText(cVar.b());
                this.b.setText(cVar.c());
                this.c.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
                this.c.setBackgroundColor(0);
                this.c.setVisibility(0);
                switch (cVar.d()) {
                    case 0:
                        this.c.setText("");
                        this.c.setSelected(((Boolean) cVar.e()).booleanValue());
                        this.c.setBackgroundResource(R.drawable.btn_switcher_selector);
                        break;
                    case 1:
                        textView = this.c;
                        strF = ((chat.ola.vn.entry.a.d) cVar).f();
                        textView.setText(strF);
                        break;
                    case 2:
                        textView = this.c;
                        strF = (String) cVar.e();
                        textView.setText(strF);
                        break;
                    case 3:
                        this.c.setText("");
                        this.c.setCompoundDrawablesWithIntrinsicBounds(0, 0, R.drawable.ic_arrow_right, 0);
                        break;
                    default:
                        try {
                            if (cVar.e() instanceof String) {
                                this.c.setText((String) cVar.e());
                            } else {
                                this.c.setText("");
                            }
                        } catch (Throwable unused) {
                            this.c.setText("");
                        }
                        this.c.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
                        break;
                }
            } catch (Throwable unused2) {
                this.c.setVisibility(8);
            }
        }
    }

    /* JADX INFO: renamed from: chat.ola.vn.b.b$b, reason: collision with other inner class name */
    private class C0022b {
        TextView a;

        public C0022b(View view) {
            this.a = (TextView) view.findViewById(R.id.txtCategoryTitle);
            view.setTag(this);
        }
    }

    public b(Context context) {
        this.a = LayoutInflater.from(context);
    }

    public void a(List<chat.ola.vn.entry.a.b> list) {
        this.b = list;
    }

    @Override // android.widget.ExpandableListAdapter
    public Object getChild(int i, int i2) {
        return this.b.get(i).a(i2);
    }

    @Override // android.widget.ExpandableListAdapter
    public long getChildId(int i, int i2) {
        return ExpandableListView.getPackedPositionForChild(i, i2);
    }

    @Override // android.widget.ExpandableListAdapter
    public View getChildView(int i, int i2, boolean z, View view, ViewGroup viewGroup) {
        a aVar;
        if (view == null) {
            view = this.a.inflate(R.layout.app_config_item_layout, (ViewGroup) null);
            aVar = new a(view);
        } else {
            aVar = (a) view.getTag();
        }
        try {
            aVar.a((chat.ola.vn.entry.a.c) getChild(i, i2));
            if (z) {
                view.setBackgroundResource(R.drawable.bg_me_comment_item_footer);
                return view;
            }
            view.setBackgroundResource(R.drawable.bg_me_comment_item);
            return view;
        } catch (Throwable th) {
            th.printStackTrace();
            return view;
        }
    }

    @Override // android.widget.ExpandableListAdapter
    public int getChildrenCount(int i) {
        return this.b.get(i).b();
    }

    @Override // android.widget.ExpandableListAdapter
    public Object getGroup(int i) {
        return this.b.get(i);
    }

    @Override // android.widget.ExpandableListAdapter
    public int getGroupCount() {
        if (this.b == null) {
            return 0;
        }
        return this.b.size();
    }

    @Override // android.widget.ExpandableListAdapter
    public long getGroupId(int i) {
        return ExpandableListView.getPackedPositionForGroup(i);
    }

    @Override // android.widget.ExpandableListAdapter
    public View getGroupView(int i, boolean z, View view, ViewGroup viewGroup) {
        C0022b c0022b;
        if (view == null) {
            view = this.a.inflate(R.layout.app_config_category_item_layout, (ViewGroup) null);
            c0022b = new C0022b(view);
        } else {
            c0022b = (C0022b) view.getTag();
        }
        c0022b.a.setText(((chat.ola.vn.entry.a.b) getGroup(i)).a());
        return view;
    }

    @Override // android.widget.ExpandableListAdapter
    public boolean hasStableIds() {
        return false;
    }

    @Override // android.widget.ExpandableListAdapter
    public boolean isChildSelectable(int i, int i2) {
        return true;
    }
}
