.class Lchat/ola/vn/m/w$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/w;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/w;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/w$4;->a:Lchat/ola/vn/m/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x3

    if-eq p2, p1, :cond_0

    if-eqz p3, :cond_2

    :try_start_0
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/16 p2, 0x42

    if-ne p1, p2, :cond_2

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/w$4;->a:Lchat/ola/vn/m/w;

    invoke-static {p1}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->length()I

    move-result p1

    if-lez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/w$4;->a:Lchat/ola/vn/m/w;

    invoke-static {p1}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/w$4;->a:Lchat/ola/vn/m/w;

    invoke-static {p2, p1}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_2
    const/4 p1, 0x0

    return p1
.end method
