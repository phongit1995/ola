.class final Lchat/ola/vn/util/c/b$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/NotificationManager;

.field final synthetic b:I


# direct methods
.method constructor <init>(Landroid/app/NotificationManager;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/c/b$5;->a:Landroid/app/NotificationManager;

    iput p2, p0, Lchat/ola/vn/util/c/b$5;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/util/c/b$5;->a:Landroid/app/NotificationManager;

    iget v1, p0, Lchat/ola/vn/util/c/b$5;->b:I

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    return-void
.end method
