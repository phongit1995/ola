.class Lcom/mg/ola/common/widget/b$e;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "e"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/b$e;-><init>(Lcom/mg/ola/common/widget/b;)V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 2

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    float-to-int v0, v0

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p2

    float-to-int p2, p2

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iget-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->f(Lcom/mg/ola/common/widget/b;)Landroid/os/Handler;

    move-result-object p1

    iget-object p2, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p2}, Lcom/mg/ola/common/widget/b;->e(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$f;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result p1

    if-eqz p1, :cond_0

    if-ltz v0, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->getWidth()I

    move-result p1

    if-ge v0, p1, :cond_0

    if-ltz p2, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->getHeight()I

    move-result p1

    if-ge p2, p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->f(Lcom/mg/ola/common/widget/b;)Landroid/os/Handler;

    move-result-object p1

    iget-object p2, p0, Lcom/mg/ola/common/widget/b$e;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p2}, Lcom/mg/ola/common/widget/b;->e(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$f;

    move-result-object p2

    const-wide/16 v0, 0xfa

    invoke-virtual {p1, p2, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    :goto_0
    const/4 p1, 0x0

    return p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
