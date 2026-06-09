.class Lchat/ola/vn/q/b$6;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/common/c/c$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/q/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$6;->c:Lchat/ola/vn/q/b;

    iput-object p2, p0, Lchat/ola/vn/q/b$6;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/q/b$6;->b:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/common/c/c;I)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/q/b$6;->a:Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result p2

    packed-switch p2, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p2, p0, Lchat/ola/vn/q/b$6;->b:Landroid/content/Context;

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p2, p0, Lchat/ola/vn/q/b$6;->b:Landroid/content/Context;

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
