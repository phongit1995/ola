.class public Lchat/ola/vn/balloon/f;
.super Landroid/widget/RelativeLayout;


# instance fields
.field public a:Landroid/view/WindowManager$LayoutParams;

.field b:Lchat/ola/vn/balloon/e;

.field private c:Lchat/ola/vn/message/d;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lchat/ola/vn/balloon/e;)V
    .locals 7

    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/balloon/f;->b:Lchat/ola/vn/balloon/e;

    invoke-virtual {p2}, Lchat/ola/vn/balloon/e;->getWindowWidth()I

    move-result p1

    invoke-virtual {p2}, Lchat/ola/vn/balloon/e;->getBalloonWidth()I

    move-result v0

    sub-int/2addr p1, v0

    new-instance v6, Landroid/view/WindowManager$LayoutParams;

    const/4 v1, -0x2

    const/4 v2, -0x2

    const/16 v3, 0x7d3

    const/16 v4, 0x28

    const/4 v5, -0x3

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v6, p0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object v0, p0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x33

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object v0, p0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object p1, p0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object v0, p2, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p2}, Lchat/ola/vn/balloon/e;->getBalloonWidth()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object p1, p0, Lchat/ola/vn/balloon/f;->a:Landroid/view/WindowManager$LayoutParams;

    iget-object p2, p2, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p2, p2, Landroid/view/WindowManager$LayoutParams;->y:I

    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    return-void
.end method

.method private a()V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/balloon/f;->removeAllViews()V

    iget-object v0, p0, Lchat/ola/vn/balloon/f;->c:Lchat/ola/vn/message/d;

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/balloon/f;->c:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    packed-switch v1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    new-instance v0, Lchat/ola/vn/entry/b/b/b;

    invoke-virtual {p0}, Lchat/ola/vn/balloon/f;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/entry/b/b/b;-><init>(Landroid/content/Context;)V

    :goto_0
    :pswitch_1
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/entry/b/b/a;->b()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p0, v1}, Lchat/ola/vn/balloon/f;->addView(Landroid/view/View;)V

    iget-object v1, p0, Lchat/ola/vn/balloon/f;->b:Lchat/ola/vn/balloon/e;

    iget-object v1, v1, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    iget-object v2, p0, Lchat/ola/vn/balloon/f;->c:Lchat/ola/vn/message/d;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/entry/b/b/a;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V

    :cond_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public setMessage(Lchat/ola/vn/message/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/f;->c:Lchat/ola/vn/message/d;

    invoke-direct {p0}, Lchat/ola/vn/balloon/f;->a()V

    return-void
.end method

.method public setVisibility(I)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/balloon/f;->c:Lchat/ola/vn/message/d;

    :cond_0
    return-void
.end method
