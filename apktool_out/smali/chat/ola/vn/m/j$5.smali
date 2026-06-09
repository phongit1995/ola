.class Lchat/ola/vn/m/j$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$5;->a:Lchat/ola/vn/m/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-nez p2, :cond_0

    sget-object p2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p2}, Lchat/ola/vn/r/b;->f()V

    sget-object p2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p2}, Lchat/ola/vn/r/b;->i()V

    iget-object p2, p0, Lchat/ola/vn/m/j$5;->a:Lchat/ola/vn/m/j;

    invoke-virtual {p2}, Lchat/ola/vn/m/j;->e()V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
