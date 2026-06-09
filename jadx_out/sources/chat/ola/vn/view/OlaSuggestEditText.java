package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.AutoCompleteTextView;
import java.lang.reflect.Method;

/* JADX INFO: loaded from: classes.dex */
public class OlaSuggestEditText extends AutoCompleteTextView {
    private a a;

    public interface a {
        String a(Object obj);
    }

    public OlaSuggestEditText(Context context) {
        super(context);
        b();
    }

    public OlaSuggestEditText(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        b();
    }

    public OlaSuggestEditText(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        b();
    }

    private void b() {
        Object[] objArr;
        try {
            for (Method method : getClass().getMethods()) {
                if (method.getName().equalsIgnoreCase("setForceIgnoreOutsideTouch")) {
                    objArr = new Object[]{true};
                } else if (method.getName().equalsIgnoreCase("setDropDownAlwaysVisible")) {
                    objArr = new Object[]{false};
                }
                method.invoke(this, objArr);
                return;
            }
        } catch (Throwable unused) {
        }
    }

    public void a() {
        performFiltering("", 0);
        showDropDown();
    }

    @Override // android.widget.AutoCompleteTextView
    protected CharSequence convertSelectionToString(Object obj) {
        return obj == null ? "" : this.a != null ? this.a.a(obj) : obj instanceof String ? super.convertSelectionToString(obj) : String.valueOf(obj);
    }

    @Override // android.widget.AutoCompleteTextView
    protected void performFiltering(CharSequence charSequence, int i) {
        if (getFilter() == null || charSequence == null) {
            return;
        }
        super.performFiltering(charSequence, i);
    }

    public void setConvertItemFactory(a aVar) {
        this.a = aVar;
    }
}
