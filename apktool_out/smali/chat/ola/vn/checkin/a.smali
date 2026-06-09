.class public Lchat/ola/vn/checkin/a;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/checkin/a$b;,
        Lchat/ola/vn/checkin/a$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lchat/ola/vn/checkin/a$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    new-instance p1, Lchat/ola/vn/checkin/a$a;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/checkin/a$a;-><init>(Lchat/ola/vn/checkin/a;Lchat/ola/vn/checkin/a$1;)V

    iput-object p1, p0, Lchat/ola/vn/checkin/a;->c:Lchat/ola/vn/checkin/a$a;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/a;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/a;->a:Ljava/util/List;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/checkin/a;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/a;->b:Ljava/util/List;

    return-object p1
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/a;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    if-nez p2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/checkin/a;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0b0050

    const/4 v1, 0x0

    invoke-virtual {p2, v0, p3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/checkin/a$b;

    invoke-direct {p3, p0, p2}, Lchat/ola/vn/checkin/a$b;-><init>(Lchat/ola/vn/checkin/a;Landroid/view/View;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/checkin/a$b;

    :goto_0
    invoke-virtual {p3, p1}, Lchat/ola/vn/checkin/a$b;->a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(I)Lchat/ola/vn/entity/OlaCheckInItemEntity;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/a;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaCheckInItemEntity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/a;->a:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/a;->b:Ljava/util/List;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/a;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getFilter()Landroid/widget/Filter;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/checkin/a;->c:Lchat/ola/vn/checkin/a$a;

    return-object v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/a;->a(I)Lchat/ola/vn/entity/OlaCheckInItemEntity;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    const-wide/16 v0, 0x0

    return-wide v0
.end method
