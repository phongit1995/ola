.class final Lchat/ola/vn/i/i$10;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->c(Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$10;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/i/i$10;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-nez p2, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/i/i$10;->a:Landroid/content/Context;

    iget-object v0, p0, Lchat/ola/vn/i/i$10;->b:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/util/b;->c(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    invoke-virtual {p2}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
