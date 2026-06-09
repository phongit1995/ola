.class Lchat/ola/vn/m/j$12$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j$12;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j$12;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j$12;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$12$2;->a:Lchat/ola/vn/m/j$12;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-nez p2, :cond_0

    sget-object p2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    iget-object v0, p0, Lchat/ola/vn/m/j$12$2;->a:Lchat/ola/vn/m/j$12;

    iget-object v0, v0, Lchat/ola/vn/m/j$12;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p2, v0}, Lchat/ola/vn/r/b;->c(Lchat/ola/vn/entity/t;)V

    sget-object p2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p2}, Lchat/ola/vn/r/b;->i()V

    iget-object p2, p0, Lchat/ola/vn/m/j$12$2;->a:Lchat/ola/vn/m/j$12;

    iget-object p2, p2, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p2}, Lchat/ola/vn/m/j;->e()V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
