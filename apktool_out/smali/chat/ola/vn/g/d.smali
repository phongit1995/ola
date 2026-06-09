.class public Lchat/ola/vn/g/d;
.super Lchat/ola/vn/g/a;


# instance fields
.field d:Lchat/ola/vn/message/f;

.field private e:Z


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/f;)V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/g/a;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/g/d;->e:Z

    const/4 v0, 0x7

    iput v0, p0, Lchat/ola/vn/g/d;->a:I

    iput-object p1, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 11

    const-string v0, ""

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, v1

    goto :goto_0

    :catch_0
    move-object v3, v0

    :goto_0
    const/4 v4, 0x0

    const v5, 0x7f0f01a7

    const v6, 0x7f0f00b7

    const v7, 0x7f0f0585

    const v8, 0x7f0f044d

    const/4 v9, 0x0

    new-instance v10, Lchat/ola/vn/g/d$2;

    invoke-direct {v10, p0}, Lchat/ola/vn/g/d$2;-><init>(Lchat/ola/vn/g/d;)V

    move-object v2, p1

    invoke-static/range {v2 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/p;

    move-result-object p1

    const/16 v0, 0x2000

    invoke-virtual {p1, v0}, Lchat/ola/vn/i/p;->b(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/g/d;Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/g/d;->a(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public a(Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0b0075

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/g/h;)Lchat/ola/vn/g/h;
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x1

    :try_start_0
    move-object v2, p2

    check-cast v2, Lchat/ola/vn/g/k;

    iget-object v3, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {v2, v3}, Lchat/ola/vn/g/k;->a(Lchat/ola/vn/message/f;)V

    move-object v2, p2

    check-cast v2, Lchat/ola/vn/g/k;

    iput-boolean v1, v2, Lchat/ola/vn/g/k;->k:Z

    move-object v2, p2

    check-cast v2, Lchat/ola/vn/g/k;

    iput-boolean v0, v2, Lchat/ola/vn/g/k;->l:Z

    move-object v2, p2

    check-cast v2, Lchat/ola/vn/g/k;

    iget-boolean v3, p0, Lchat/ola/vn/g/d;->e:Z

    invoke-virtual {v2, v3}, Lchat/ola/vn/g/k;->c(Z)V

    iget-boolean v2, p0, Lchat/ola/vn/g/d;->c:Z

    iput-boolean v2, p2, Lchat/ola/vn/g/h;->b:Z

    iget-boolean v2, p0, Lchat/ola/vn/g/d;->b:Z

    iput-boolean v2, p2, Lchat/ola/vn/g/h;->a:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    new-instance p2, Lchat/ola/vn/g/k;

    iget-object v2, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-direct {p2, v2, p1}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V

    iput-boolean v1, p2, Lchat/ola/vn/g/k;->k:Z

    iput-boolean v0, p2, Lchat/ola/vn/g/k;->l:Z

    iget-boolean p1, p0, Lchat/ola/vn/g/d;->e:Z

    invoke-virtual {p2, p1}, Lchat/ola/vn/g/k;->c(Z)V

    iget-boolean p1, p0, Lchat/ola/vn/g/d;->c:Z

    iput-boolean p1, p2, Lchat/ola/vn/g/k;->b:Z

    iget-boolean p1, p0, Lchat/ola/vn/g/d;->b:Z

    iput-boolean p1, p2, Lchat/ola/vn/g/k;->a:Z

    return-object p2
.end method

.method public a(Landroid/content/Context;Landroid/view/View;IJ)Z
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    if-nez p2, :cond_0

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    const p3, 0x7f0f069f

    invoke-virtual {p1, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p3, 0x7f0f0453

    invoke-virtual {p1, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p3, 0x7f0f04a6

    invoke-virtual {p1, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p3, 0x7f0f043a

    invoke-virtual {p1, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p3, Lchat/ola/vn/i/m;

    invoke-direct {p3, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    iget-object p4, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {p4}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p4

    invoke-virtual {p3, p4}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    invoke-virtual {p3, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p4, Lchat/ola/vn/g/d$1;

    invoke-direct {p4, p0, p2, p1}, Lchat/ola/vn/g/d$1;-><init>(Lchat/ola/vn/g/d;Ljava/util/List;Landroid/content/Context;)V

    invoke-virtual {p3, p4}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p3}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public b(Landroid/content/Context;Landroid/view/View;IJ)V
    .locals 0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p3, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p3

    iget-object p4, p0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {p4}, Lchat/ola/vn/message/f;->k()S

    move-result p4

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/g/d;->e:Z

    return-void
.end method
