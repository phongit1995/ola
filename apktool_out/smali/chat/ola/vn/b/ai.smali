.class public Lchat/ola/vn/b/ai;
.super Lchat/ola/vn/b/k;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/ai$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/k<",
        "Lchat/ola/vn/entity/t;",
        ">;"
    }
.end annotation


# instance fields
.field protected b:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/k;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/ai;->b:Landroid/view/LayoutInflater;

    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p1}, Lchat/ola/vn/r/b;->d()Ljava/util/List;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ai;->a(Ljava/util/List;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/t;Lchat/ola/vn/entity/t;)I
    .locals 5

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide v2

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide p1

    cmp-long v2, v0, p1

    if-gez v2, :cond_1

    const/4 p1, -0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 1

    if-nez p2, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/b/ai;->b:Landroid/view/LayoutInflater;

    const p3, 0x7f0b01b1

    const/4 v0, 0x0

    invoke-virtual {p2, p3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/b/ai$a;

    invoke-direct {p3, p0, p2}, Lchat/ola/vn/b/ai$a;-><init>(Lchat/ola/vn/b/ai;Landroid/view/View;)V

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/b/ai$a;

    :goto_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ai;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    invoke-virtual {p3, p1}, Lchat/ola/vn/b/ai$a;->a(Lchat/ola/vn/entity/t;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    new-instance p1, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/b/ai;->b()Landroid/content/Context;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1
.end method

.method protected a(Lchat/ola/vn/entity/t;)Ljava/lang/String;
    .locals 0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->l()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected bridge synthetic a(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/t;

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ai;->a(Lchat/ola/vn/entity/t;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/t;

    check-cast p2, Lchat/ola/vn/entity/t;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/b/ai;->a(Lchat/ola/vn/entity/t;Lchat/ola/vn/entity/t;)I

    move-result p1

    return p1
.end method
