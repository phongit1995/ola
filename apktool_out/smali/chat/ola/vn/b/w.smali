.class public Lchat/ola/vn/b/w;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/w$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/message/f;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/View$OnClickListener;

.field private b:Landroid/view/View$OnLongClickListener;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/w;)Landroid/view/View$OnClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/w;->a:Landroid/view/View$OnClickListener;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/b/w;)Landroid/view/View$OnLongClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/w;->b:Landroid/view/View$OnLongClickListener;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/b/w;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/w;->c:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/w;->e:Landroid/view/LayoutInflater;

    const v1, 0x7f0b01b9

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/b/w$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/b/w$a;-><init>(Lchat/ola/vn/b/w;Landroid/view/View;)V

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v0, p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/b/w$a;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v3, v0

    move-object v0, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/w;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p2, p1}, Lchat/ola/vn/b/w$a;->a(Lchat/ola/vn/message/f;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_1
    if-nez v0, :cond_1

    return-object p3

    :cond_1
    return-object v0
.end method

.method public a(I)Lchat/ola/vn/message/f;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/w;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/w;->a:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/w;->b:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/b/w;->c:Ljava/util/List;

    invoke-virtual {p0}, Lchat/ola/vn/b/w;->notifyDataSetChanged()V

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/w;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/w;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method
