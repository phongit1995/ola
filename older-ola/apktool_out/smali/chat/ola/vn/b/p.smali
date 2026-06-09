.class public Lchat/ola/vn/b/p;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/p$a;,
        Lchat/ola/vn/b/p$b;,
        Lchat/ola/vn/b/p$c;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/OlaVenueEntity;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lchat/ola/vn/b/p$c;

.field private d:Lchat/ola/vn/b/p$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lchat/ola/vn/b/p$a<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation
.end field

.field private g:Landroid/view/View$OnLongClickListener;

.field private h:Landroid/view/View$OnClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    new-instance p1, Lchat/ola/vn/b/p$c;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/b/p$c;-><init>(Lchat/ola/vn/b/p;Lchat/ola/vn/b/p$1;)V

    iput-object p1, p0, Lchat/ola/vn/b/p;->c:Lchat/ola/vn/b/p$c;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/p;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/p;->a:Ljava/util/List;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/b/p;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/b/p;)Lchat/ola/vn/b/p$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/p;->d:Lchat/ola/vn/b/p$a;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/b/p;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    if-nez p2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/b/p;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0b004a

    const/4 v1, 0x0

    invoke-virtual {p2, v0, p3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/b/p$b;

    invoke-direct {p3, p0, p2}, Lchat/ola/vn/b/p$b;-><init>(Lchat/ola/vn/b/p;Landroid/view/View;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/b/p$b;

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/b/p;->h:Landroid/view/View$OnClickListener;

    invoke-virtual {p3, v0}, Lchat/ola/vn/b/p$b;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/p;->g:Landroid/view/View$OnLongClickListener;

    invoke-virtual {p3, v0}, Lchat/ola/vn/b/p$b;->a(Landroid/view/View$OnLongClickListener;)V

    invoke-virtual {p3, p1}, Lchat/ola/vn/b/p$b;->a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(I)Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/p;->h:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Lchat/ola/vn/b/p$a;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/b/p$a<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/p;->d:Lchat/ola/vn/b/p$a;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/b/p;->a:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    invoke-virtual {p0}, Lchat/ola/vn/b/p;->notifyDataSetChanged()V

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/p;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public getFilter()Landroid/widget/Filter;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/p;->c:Lchat/ola/vn/b/p$c;

    return-object v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/p;->a(I)Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object p1

    return-object p1
.end method
