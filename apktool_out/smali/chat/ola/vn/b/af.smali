.class public Lchat/ola/vn/b/af;
.super Landroid/widget/BaseAdapter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/af$a;
    }
.end annotation


# instance fields
.field protected a:Landroid/view/LayoutInflater;

.field private b:Z

.field private c:Lchat/ola/vn/r/a/f;

.field private d:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lchat/ola/vn/r/a/f;)V
    .locals 1

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/b/af;->b:Z

    iput-object p2, p0, Lchat/ola/vn/b/af;->c:Lchat/ola/vn/r/a/f;

    iput-object p1, p0, Lchat/ola/vn/b/af;->d:Landroid/content/Context;

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/af;->a:Landroid/view/LayoutInflater;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/af;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/af;->d:Landroid/content/Context;

    return-object p0
.end method


# virtual methods
.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/b/af;->b:Z

    return-void
.end method

.method public getCount()I
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/af;->c:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->g()I

    move-result v0

    iget-boolean v1, p0, Lchat/ola/vn/b/af;->b:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v0, v1

    return v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 v0, 0x1

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/b/af;->b:Z

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/b/af;->c:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object p1

    return-object p1

    :catch_0
    move-exception p1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/af;->c:Lchat/ola/vn/r/a/f;

    add-int/lit8 p1, p1, -0x1

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/f;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :goto_0
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/b/af;->c:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/f;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/b/af;->b:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    if-nez p1, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/af;->getItemViewType(I)I

    move-result v0

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_4

    :pswitch_0
    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/af;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    if-nez p2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/b/af;->a:Landroid/view/LayoutInflater;

    const v3, 0x7f0b0075

    invoke-virtual {v2, v3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance p2, Lchat/ola/vn/g/k;

    invoke-direct {p2, v0, v2}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V

    invoke-virtual {v2, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/g/k;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-object v2, p2

    move-object p2, v0

    :goto_0
    if-eqz p2, :cond_1

    const/4 v0, 0x1

    :try_start_3
    iput-boolean v0, p2, Lchat/ola/vn/g/k;->k:Z

    iput-boolean v0, p2, Lchat/ola/vn/g/k;->l:Z

    invoke-virtual {p2, p1}, Lchat/ola/vn/g/k;->b(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    :cond_1
    return-object v2

    :catch_1
    move-exception v0

    move-object v2, p2

    move-object p2, v0

    :goto_1
    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    move-object p2, v2

    :pswitch_1
    if-nez p2, :cond_2

    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/b/af;->a:Landroid/view/LayoutInflater;

    const v2, 0x7f0b00b8

    invoke-virtual {v0, v2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :try_start_5
    sget p2, Lchat/ola/vn/f;->r:I

    invoke-virtual {v0, p2}, Landroid/view/View;->setBackgroundColor(I)V

    new-instance p2, Lchat/ola/vn/b/af$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/b/af$a;-><init>(Lchat/ola/vn/b/af;Landroid/view/View;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_2

    :catch_2
    move-exception p1

    move-object p2, v0

    goto :goto_3

    :catch_3
    move-exception p1

    goto :goto_3

    :cond_2
    :try_start_6
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/b/af$a;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    move-object v4, v0

    move-object v0, p2

    move-object p2, v4

    :goto_2
    :try_start_7
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/af;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    if-eqz p1, :cond_3

    check-cast p1, Lchat/ola/vn/entity/s;

    invoke-virtual {p2, p1}, Lchat/ola/vn/b/af$a;->a(Lchat/ola/vn/entity/s;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_2

    :cond_3
    return-object v0

    :goto_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_4
    if-eqz p2, :cond_4

    return-object p2

    :cond_4
    if-eqz p3, :cond_5

    return-object p3

    :cond_5
    new-instance p1, Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/b/af;->d:Landroid/content/Context;

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public getViewTypeCount()I
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/b/af;->b:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method
