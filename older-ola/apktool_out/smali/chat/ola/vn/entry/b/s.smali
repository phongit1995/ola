.class public Lchat/ola/vn/entry/b/s;
.super Lchat/ola/vn/entry/b/f;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private t:Lchat/ola/vn/message/c;

.field private u:Lchat/ola/vn/i/c;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b/s;->u:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/entry/b/s;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/s;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/s;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f090374

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090399

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/s;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/s;)Lchat/ola/vn/i/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/s;->u:Lchat/ola/vn/i/c;

    return-object p0
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/c;

    iput-object p1, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090374

    if-eq p1, v0, :cond_2

    const v0, 0x7f090399

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;

    invoke-virtual {p1}, Lchat/ola/vn/message/c;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/s;->u:Lchat/ola/vn/i/c;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b/s;->u:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/entry/b/s;->u:Lchat/ola/vn/i/c;

    const v1, 0x7f0f028e

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/s;->u:Lchat/ola/vn/i/c;

    const-wide/16 v1, 0x7530

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/entry/b/s$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/s$1;-><init>(Lchat/ola/vn/entry/b/s;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;S)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;

    invoke-virtual {p1}, Lchat/ola/vn/message/c;->f()Lchat/ola/vn/message/f;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;

    :goto_0
    invoke-virtual {v0}, Lchat/ola/vn/message/c;->p()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->l(Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;

    invoke-virtual {p1}, Lchat/ola/vn/message/c;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;S)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;

    invoke-virtual {p1}, Lchat/ola/vn/message/c;->f()Lchat/ola/vn/message/f;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/s;->t:Lchat/ola/vn/message/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_3
    return-void
.end method
