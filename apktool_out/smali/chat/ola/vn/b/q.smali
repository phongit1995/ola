.class public Lchat/ola/vn/b/q;
.super Landroid/widget/BaseAdapter;

# interfaces
.implements Landroid/widget/Filterable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/q$a;,
        Lchat/ola/vn/b/q$b;
    }
.end annotation


# instance fields
.field public a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/entity/x;",
            ">;"
        }
    .end annotation
.end field

.field private b:Landroid/view/LayoutInflater;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/x;",
            ">;"
        }
    .end annotation
.end field

.field private d:Landroid/widget/Filter;

.field private final e:Ljava/lang/Object;

.field private f:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/b/q;->e:Ljava/lang/Object;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/b/q;->f:Z

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/q;->b:Landroid/view/LayoutInflater;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/q;)Ljava/lang/Object;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/q;->e:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/b/q;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/q;->c:Ljava/util/List;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/b/q;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/q;->c:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public a(Landroid/widget/Filter;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/q;->d:Landroid/widget/Filter;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/x;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/b/q;->a:Ljava/util/ArrayList;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/q;->c:Ljava/util/List;

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

    iget-object v0, p0, Lchat/ola/vn/b/q;->d:Landroid/widget/Filter;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/q$b;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q$b;-><init>(Lchat/ola/vn/b/q;)V

    iput-object v0, p0, Lchat/ola/vn/b/q;->d:Landroid/widget/Filter;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/q;->d:Landroid/widget/Filter;

    return-object v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/q;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

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

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/q;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/x;

    iget-byte p1, p1, Lchat/ola/vn/entity/x;->a:B
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/q;->b:Landroid/view/LayoutInflater;

    const v1, 0x7f0b01ae

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/entry/b/aj;

    invoke-direct {p2, v0}, Lchat/ola/vn/entry/b/aj;-><init>(Landroid/view/View;)V

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

    check-cast v0, Lchat/ola/vn/entry/b/aj;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v3, v0

    move-object v0, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    iget-boolean v1, p0, Lchat/ola/vn/b/q;->f:Z

    invoke-virtual {p2, v1}, Lchat/ola/vn/entry/b/aj;->a(Z)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/q;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/x;

    invoke-virtual {p2, p1}, Lchat/ola/vn/entry/b/aj;->a(Lchat/ola/vn/entity/x;)V

    iget-object p1, p2, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/CheckBox;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_1
    if-nez v0, :cond_1

    return-object p3

    :cond_1
    return-object v0
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

.method public notifyDataSetChanged()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/q;->c:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/q;->c:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    :cond_0
    invoke-super {p0}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V

    return-void
.end method
