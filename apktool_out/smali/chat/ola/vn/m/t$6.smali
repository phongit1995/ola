.class Lchat/ola/vn/m/t$6;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/common/c/c$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/t;->a(Landroid/view/View;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/m/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/t;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/t$6;->b:Lchat/ola/vn/m/t;

    iput-object p2, p0, Lchat/ola/vn/m/t$6;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/common/c/c;I)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/t$6;->a:Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result p2

    packed-switch p2, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p2, p0, Lchat/ola/vn/m/t$6;->b:Lchat/ola/vn/m/t;

    invoke-virtual {p2}, Lchat/ola/vn/m/t;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p2, p0, Lchat/ola/vn/m/t$6;->b:Lchat/ola/vn/m/t;

    invoke-virtual {p2}, Lchat/ola/vn/m/t;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
