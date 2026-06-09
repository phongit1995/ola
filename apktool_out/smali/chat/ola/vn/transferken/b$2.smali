.class Lchat/ola/vn/transferken/b$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/transferken/b;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/transferken/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/transferken/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/transferken/b$2;->a:Lchat/ola/vn/transferken/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 1

    if-eqz p2, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/transferken/b$2;->a:Lchat/ola/vn/transferken/b;

    invoke-static {p1}, Lchat/ola/vn/transferken/b;->b(Lchat/ola/vn/transferken/b;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, ","

    const-string v0, ""

    invoke-virtual {p1, p2, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/transferken/b$2;->a:Lchat/ola/vn/transferken/b;

    invoke-static {p2}, Lchat/ola/vn/transferken/b;->b(Lchat/ola/vn/transferken/b;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/transferken/b$2;->a:Lchat/ola/vn/transferken/b;

    invoke-static {p1}, Lchat/ola/vn/transferken/b;->b(Lchat/ola/vn/transferken/b;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, ","

    const-string v0, ""

    invoke-virtual {p1, p2, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide p1

    iget-object v0, p0, Lchat/ola/vn/transferken/b$2;->a:Lchat/ola/vn/transferken/b;

    invoke-static {v0}, Lchat/ola/vn/transferken/b;->b(Lchat/ola/vn/transferken/b;)Landroid/widget/EditText;

    move-result-object v0

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
