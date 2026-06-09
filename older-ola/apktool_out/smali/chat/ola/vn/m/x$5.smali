.class Lchat/ola/vn/m/x$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/x;->a(Landroid/content/Context;)Ljava/util/ArrayList;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/x;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/x$5;->a:Lchat/ola/vn/m/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/m/x$5;->a:Lchat/ola/vn/m/x;

    invoke-virtual {p1}, Lchat/ola/vn/m/x;->f()Lchat/ola/vn/m/j;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/x$5;->a:Lchat/ola/vn/m/x;

    iget-object v0, v0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/entity/t;)V

    return-void
.end method
