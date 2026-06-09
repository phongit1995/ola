.class Lchat/ola/vn/m/y$9;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y;->a(Landroid/content/Context;)Ljava/util/ArrayList;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/y;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$9;->a:Lchat/ola/vn/m/y;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/m/y$9;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->f()Lchat/ola/vn/m/j;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/y$9;->a:Lchat/ola/vn/m/y;

    iget-object v0, v0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/entity/t;)V

    return-void
.end method
