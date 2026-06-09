.class Lchat/ola/vn/m/j$11;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 p1, 0x0

    :try_start_0
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/16 v0, 0x42

    if-eq p3, v0, :cond_0

    const/4 p3, 0x3

    if-ne p2, p3, :cond_4

    :cond_0
    :try_start_1
    sget-object p2, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    if-eqz p2, :cond_3

    sget-object p2, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p2

    sget-object p3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p2, p3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "note/"

    invoke-virtual {p2, p3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    const-string p3, "note"

    :goto_0
    invoke-static {p2, p3}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_1

    :cond_1
    sget-object p2, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p2

    sget-object p3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p2, p3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "fic/"

    invoke-virtual {p2, p3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    const-string p3, "fic"

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    const-string p3, "news"
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :cond_3
    :goto_1
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    iget-object p3, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    invoke-static {p3}, Lchat/ola/vn/m/j;->f(Lchat/ola/vn/m/j;)Ljava/lang/String;

    move-result-object p3

    iget-object v0, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->g(Lchat/ola/vn/m/j;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, p3, v0}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_4

    iget-object p3, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    invoke-virtual {p3}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    iget-object v0, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->g(Lchat/ola/vn/m/j;)Landroid/widget/EditText;

    move-result-object v0

    invoke-static {p3, v0, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object p3, p0, Lchat/ola/vn/m/j$11;->a:Lchat/ola/vn/m/j;

    new-instance v0, Lchat/ola/vn/entity/t;

    invoke-direct {v0, p2}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, v0}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    const/4 p1, 0x1

    :catch_1
    :cond_4
    return p1
.end method
