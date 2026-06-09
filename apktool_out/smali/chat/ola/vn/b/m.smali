.class public Lchat/ola/vn/b/m;
.super Landroid/widget/BaseAdapter;


# instance fields
.field private a:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    return-void
.end method

.method private a()Landroid/view/LayoutInflater;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/m;->a:Landroid/view/LayoutInflater;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const-string v1, "layout_inflater"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    iput-object v0, p0, Lchat/ola/vn/b/m;->a:Landroid/view/LayoutInflater;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/m;->a:Landroid/view/LayoutInflater;

    return-object v0
.end method


# virtual methods
.method public getCount()I
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->E()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->d(I)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 2

    if-nez p2, :cond_0

    :try_start_0
    new-instance p3, Lchat/ola/vn/g/d;

    const/4 v0, 0x0

    invoke-direct {p3, v0}, Lchat/ola/vn/g/d;-><init>(Lchat/ola/vn/message/f;)V

    invoke-direct {p0}, Lchat/ola/vn/b/m;->a()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-virtual {p3, v0}, Lchat/ola/vn/g/d;->a(Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object p3

    move-object p2, p3

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_2

    :cond_0
    :goto_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/g/k;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->d(I)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez p3, :cond_1

    new-instance p3, Lchat/ola/vn/g/k;

    invoke-direct {p3, v0, p2}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V

    :cond_1
    invoke-virtual {p3, v0}, Lchat/ola/vn/g/k;->a(Lchat/ola/vn/message/f;)V

    invoke-virtual {p0}, Lchat/ola/vn/b/m;->getCount()I

    move-result v0

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    if-lt p1, v0, :cond_2

    invoke-virtual {p3, v1}, Lchat/ola/vn/g/k;->a(Z)V

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    invoke-virtual {p3, v0}, Lchat/ola/vn/g/k;->a(Z)V

    :goto_1
    invoke-virtual {p2, p3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p3, p1}, Lchat/ola/vn/g/k;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :goto_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p2
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
