.class public Lchat/ola/vn/g/c;
.super Lchat/ola/vn/g/a;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/g/a;-><init>()V

    const/4 v0, 0x2

    iput v0, p0, Lchat/ola/vn/g/c;->a:I

    return-void
.end method


# virtual methods
.method public a(Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0b0074

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/g/h;)Lchat/ola/vn/g/h;
    .locals 1

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/g/c;->c:Z

    iput-boolean v0, p2, Lchat/ola/vn/g/h;->b:Z

    iget-boolean v0, p0, Lchat/ola/vn/g/c;->b:Z

    iput-boolean v0, p2, Lchat/ola/vn/g/h;->a:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    new-instance p2, Lchat/ola/vn/g/j;

    invoke-direct {p2, p1}, Lchat/ola/vn/g/j;-><init>(Landroid/view/View;)V

    iget-boolean p1, p0, Lchat/ola/vn/g/c;->c:Z

    iput-boolean p1, p2, Lchat/ola/vn/g/j;->b:Z

    iget-boolean p1, p0, Lchat/ola/vn/g/c;->b:Z

    iput-boolean p1, p2, Lchat/ola/vn/g/j;->a:Z

    return-object p2
.end method

.method public b(Landroid/content/Context;Landroid/view/View;IJ)V
    .locals 0

    :try_start_0
    invoke-static {}, Lcom/facebook/share/widget/AppInviteDialog;->canShow()Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Lcom/facebook/share/model/AppInviteContent$Builder;

    invoke-direct {p1}, Lcom/facebook/share/model/AppInviteContent$Builder;-><init>()V

    const-string p2, "https://fb.me/1199434326766314"

    invoke-virtual {p1, p2}, Lcom/facebook/share/model/AppInviteContent$Builder;->setApplinkUrl(Ljava/lang/String;)Lcom/facebook/share/model/AppInviteContent$Builder;

    move-result-object p1

    const-string p2, "http://s1.cdn.kaspee.com/ola/preview.jpg"

    invoke-virtual {p1, p2}, Lcom/facebook/share/model/AppInviteContent$Builder;->setPreviewImageUrl(Ljava/lang/String;)Lcom/facebook/share/model/AppInviteContent$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/share/model/AppInviteContent$Builder;->build()Lcom/facebook/share/model/AppInviteContent;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    invoke-static {p2, p1}, Lcom/facebook/share/widget/AppInviteDialog;->show(Landroid/app/Activity;Lcom/facebook/share/model/AppInviteContent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
