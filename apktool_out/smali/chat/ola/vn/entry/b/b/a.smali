.class public abstract Lchat/ola/vn/entry/b/b/a;
.super Ljava/lang/Object;


# instance fields
.field protected a:Landroid/content/Context;

.field protected b:Landroid/view/LayoutInflater;

.field private c:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entry/b/b/a;->a:Landroid/content/Context;

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/b/a;->b:Landroid/view/LayoutInflater;

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/b/a;->a()Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/b/a;->c:Landroid/view/View;

    return-void
.end method


# virtual methods
.method protected abstract a()Landroid/view/View;
.end method

.method public abstract a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
.end method

.method public b()Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/b/a;->c:Landroid/view/View;

    return-object v0
.end method
