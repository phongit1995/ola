.class Lchat/ola/vn/signup/c$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/c;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/c$3;->a:Lchat/ola/vn/signup/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    if-eqz p3, :cond_0

    :try_start_0
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/16 p3, 0x42

    if-eq p1, p3, :cond_1

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_0
    :goto_0
    const/4 p1, 0x6

    if-ne p2, p1, :cond_2

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/c$3;->a:Lchat/ola/vn/signup/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/c;->x()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_2
    const/4 p1, 0x0

    return p1
.end method
