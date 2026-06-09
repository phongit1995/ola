.class Lchat/ola/vn/util/http/WebAppInterfaceImp$19;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/http/WebAppInterfaceImp;->openMedias([Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:[Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/util/http/WebAppInterfaceImp;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;I[Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iput p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;->a:I

    iput-object p3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;->b:[Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;->a:I

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;->b:[Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a([Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v0, v3, v3, v1, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void
.end method
