.class Lchat/ola/vn/m/t$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/t;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/t$7;->a:Lchat/ola/vn/m/t;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/m/t$7;->a:Lchat/ola/vn/m/t;

    iget-object p1, p1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->j(I)V

    iget-object p1, p0, Lchat/ola/vn/m/t$7;->a:Lchat/ola/vn/m/t;

    invoke-virtual {p1}, Lchat/ola/vn/m/t;->c()V

    iget-object p1, p0, Lchat/ola/vn/m/t$7;->a:Lchat/ola/vn/m/t;

    invoke-virtual {p1}, Lchat/ola/vn/m/t;->v()V

    return-void
.end method
