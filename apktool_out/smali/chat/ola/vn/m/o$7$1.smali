.class Lchat/ola/vn/m/o$7$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o$7;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o$7;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o$7;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$7$1;->a:Lchat/ola/vn/m/o$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    if-eqz p2, :cond_0

    goto :goto_1

    :cond_0
    :try_start_0
    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_2

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-nez v2, :cond_1

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/g;->c(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-interface {p2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_2
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/g;->a(Ljava/util/List;)V

    iget-object p2, p0, Lchat/ola/vn/m/o$7$1;->a:Lchat/ola/vn/m/o$7;

    iget-object p2, p2, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    invoke-static {p2}, Lchat/ola/vn/m/o;->b(Lchat/ola/vn/m/o;)V

    :goto_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
