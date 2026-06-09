.class public abstract Lchat/ola/vn/b/j;
.super Landroid/widget/BaseAdapter;

# interfaces
.implements Landroid/widget/Filterable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/j$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Landroid/widget/BaseAdapter;",
        "Landroid/widget/Filterable;"
    }
.end annotation


# instance fields
.field private a:Landroid/content/Context;

.field protected e:Landroid/view/LayoutInflater;

.field protected f:Lchat/ola/vn/b/j$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/b/j;->a:Landroid/content/Context;

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/j;->e:Landroid/view/LayoutInflater;

    return-void
.end method

.method private a(I)V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/b/j;->getCount()I

    move-result v0

    if-eqz v0, :cond_2

    if-nez p1, :cond_0

    return-void

    :cond_0
    add-int/lit8 v0, v0, -0x1

    add-int/lit8 v1, v0, -0x5

    if-gez v1, :cond_1

    move v1, v0

    :cond_1
    if-ne p1, v1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/j;->f:Lchat/ola/vn/b/j$a;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/j;->f:Lchat/ola/vn/b/j$a;

    invoke-interface {p1}, Lchat/ola/vn/b/j$a;->B()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/j;->f:Lchat/ola/vn/b/j$a;

    invoke-interface {p1, v0}, Lchat/ola/vn/b/j$a;->a_(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_2
    return-void
.end method


# virtual methods
.method public abstract a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end method

.method public a(Lchat/ola/vn/b/j$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/j;->f:Lchat/ola/vn/b/j$a;

    return-void
.end method

.method public b()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/j;->a:Landroid/content/Context;

    return-object v0
.end method

.method public abstract getCount()I
.end method

.method public getFilter()Landroid/widget/Filter;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public final getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lchat/ola/vn/b/j;->a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;->a(I)V

    return-object p2
.end method
