.class Lchat/ola/vn/signup/fb/d$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/fb/d;->a(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d$2;->a:Lchat/ola/vn/signup/fb/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/16 p3, 0x42

    if-eq p1, p3, :cond_1

    :cond_0
    const/4 p1, 0x6

    if-ne p2, p1, :cond_2

    :cond_1
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$2;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->g(Lchat/ola/vn/signup/fb/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    const/4 p1, 0x0

    return p1
.end method
