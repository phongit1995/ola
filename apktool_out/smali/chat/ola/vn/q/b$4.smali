.class Lchat/ola/vn/q/b$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b;->h(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lchat/ola/vn/entry/b;

.field final synthetic c:Lchat/ola/vn/q/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$4;->c:Lchat/ola/vn/q/b;

    iput-object p2, p0, Lchat/ola/vn/q/b$4;->a:Landroid/content/Context;

    iput-object p3, p0, Lchat/ola/vn/q/b$4;->b:Lchat/ola/vn/entry/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/q/b$4;->c:Lchat/ola/vn/q/b;

    iget-object v0, p0, Lchat/ola/vn/q/b$4;->a:Landroid/content/Context;

    iget-object v1, p0, Lchat/ola/vn/q/b$4;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
