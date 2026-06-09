.class public abstract Lchat/ola/vn/entry/b/a/b;
.super Ljava/lang/Object;


# instance fields
.field protected a:Landroid/content/Context;

.field protected b:Lchat/ola/vn/entry/b;

.field protected c:Landroid/view/View;

.field protected d:Landroid/view/View$OnClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    :try_start_0
    invoke-virtual {p2}, Landroid/view/ViewGroup;->removeAllViews()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iput-object p1, p0, Lchat/ola/vn/entry/b/a/b;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/b;->c:Landroid/view/View;

    iput-object p3, p0, Lchat/ola/vn/entry/b/a/b;->d:Landroid/view/View$OnClickListener;

    return-void
.end method


# virtual methods
.method abstract a(Lchat/ola/vn/entry/b/ab;)V
.end method

.method public final a(Lchat/ola/vn/entry/b/ab;Lchat/ola/vn/entry/b;)V
    .locals 0

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/b;->b:Lchat/ola/vn/entry/b;

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/b;->b:Lchat/ola/vn/entry/b;

    if-nez p2, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/b/a/b;->b(Lchat/ola/vn/entry/b/ab;)V

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/b/a/b;->a(Lchat/ola/vn/entry/b/ab;)V

    return-void
.end method

.method public abstract a(B)Z
.end method

.method public b()Lchat/ola/vn/entry/b;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/b;->b:Lchat/ola/vn/entry/b;

    return-object v0
.end method

.method abstract b(Lchat/ola/vn/entry/b/ab;)V
.end method
