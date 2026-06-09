.class Lchat/ola/vn/m/y$8;
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

    iput-object p1, p0, Lchat/ola/vn/m/y$8;->a:Lchat/ola/vn/m/y;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/m/y$8;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->f()Lchat/ola/vn/m/j;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/entity/t;

    const/4 v1, 0x0

    check-cast v1, Ljava/lang/String;

    invoke-direct {v0, v1}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;)V

    return-void
.end method
